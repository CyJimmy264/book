// crypto.js

export async function registerKey(plainKey) {
    // const keys = JSON.parse(localStorage.getItem("keys") || "[]")
    // keys.push(plainKey)
    // localStorage.setItem("keys", JSON.stringify(keys))

    localStorage.setItem("keys", plainKey)
}
