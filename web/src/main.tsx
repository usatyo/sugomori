import { StrictMode } from "react"
import { createRoot } from "react-dom/client"
import App from "./App.tsx"
import "./index.css"
import JosekiProvider from "./provider/JosekiProvider.tsx"

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <JosekiProvider>
      <App />
    </JosekiProvider>
  </StrictMode>
)
