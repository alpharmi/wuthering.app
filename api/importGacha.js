async function handler(req, res) {
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

    console.log(gacha)

    //res.json(gacha)
}

/*
handler({
    query: {
        svr_id: "86d52186155b148b5c138ceb41be9650",
        resources_id: "4df1ed7da8530acc4263774922de7d71",
        record_id: "6edcf9c141282139bc72dd8e4dae8b86",
        player_id: "700362390",
        gacha_type: 5
    }
})
*/