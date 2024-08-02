async function SendToClient(url, data) {
    
    const resource = GetParentResourceName();
    await fetch(`https://${resource}/${url}`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json; charset=UTF-8"
        },
        body: JSON.stringify(data)
    })
}



// [[ Nui Dev Tools ]] \\
var Nui = Object.defineProperties(new Error, {
    message: {
        get() {
            SendToClient("nuiDetected")
        }
    },
    toString: {
        value() {
            new Error().stack.includes("toString@") && console.log("Safari")
        }
    }
});
console.log(Nui);