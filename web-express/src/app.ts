import "dotenv/config"

import cors from "cors"
import express from "express"

const PORT = process.env.PORT || 2783
const app = express()

app.use(cors())
app.use(express.json())

let state = "off"

app.use((req, res, next) => {
	const accessKey = req.headers.authorization?.slice("Bearer ".length)

	if (accessKey === process.env.ACCESS_KEY) {
		next()
	} else {
		res.status(400).send("Invalid access key")
	}
})

app.get("/", (req, res) => {
	res.send(state)
})

app.put("/", (req, res) => {
	state = req.body.state
	res.end()
})

app.post("/", (req, res) => {
	state = "off"
	res.end()
})

app.listen(PORT, () => console.log(`Server running on PORT ${PORT}`))
