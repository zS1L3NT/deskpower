import "dotenv/config"

import cors from "cors"
import express from "express"

const PORT = process.env.PORT || 2783
const app = express()

app.use(cors())
app.use(express.json())

let lastOnline = new Date(0)
let lastSignal = new Date(0)
let state = false

app.use((req, res, next) => {
	const accessKey = req.headers.authorization?.slice("Bearer ".length).trim()

	if (accessKey === process.env.ACCESS_KEY) {
		next()
	} else {
		res.status(403).send("Invalid access key")
	}
})

app.get("/flutter/status", (req, res) => {
	res.json({
		lastOnline,
		lastSignal,
		state
	})
})

app.post("/flutter/signal", (req, res) => {
	state = true
	res.end()
})

app.get("/arduino", (req, res) => {
	lastOnline = new Date()
	res.send(state)
})

app.post("/arduino", (req, res) => {
	lastOnline = new Date()
	lastSignal = new Date()
	state = false
	res.end()
})

app.listen(PORT, () => console.log(`Server running on PORT ${PORT}`))
