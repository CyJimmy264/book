// crypto.js

export async function registerKey(plainKey) {
    // const keys = JSON.parse(localStorage.getItem("keys") || "[]")
    // keys.push(plainKey)
    // localStorage.setItem("keys", JSON.stringify(keys))
  if (plainKey) localStorage.setItem("keys", plainKey)
}
