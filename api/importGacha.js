//const express = require("express")
//const router = express.Router()

export default async function handler(req, res) { //async function handler(req, res) {
    res.setHeader('Access-Control-Allow-Credentials', true)
    res.setHeader('Access-Control-Allow-Origin', '*')
    res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT')

    const query = req.query
    var gacha = {}

    if (query && Object.keys(query).length > 0) {
        const gachaData = await fetch("https://gmserver-api.aki-game2.net/gacha/record/query", {
            method: "POST",
            body: JSON.stringify({
                cardPoolId: query.resources_id,
                cardPoolType: query.gacha_type,
                languageCode: "en",
                playerId: query.player_id,
                recordId: query.record_id,
                serverId: query.svr_id
            }),
            headers: {
                "Content-Type": "application/json"
            }
        }).then(response => response.json())

        if (gachaData && gachaData.data) {
            gacha = gachaData.data
        }
    }

    res.json(gacha)
}

//router.get("/importGacha", handler)

//module.exports = router