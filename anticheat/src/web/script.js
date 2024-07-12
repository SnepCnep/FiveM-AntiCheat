var obj = Object.defineProperties(new Error,  {
    message: {get() {
        $.post(`http://${GetParentResourceName()}/nuiDetected}`)}
    },
    toString: { value() { (new Error).stack.includes('toString@')&&console.log('Safari')} }
});