const express = require("express")
const app = express()
const cors = require("cors")

app.use(cors())

const routes = [require("./api/importGacha")]

app.use("/api", routes)
app.listen(3000)