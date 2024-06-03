import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import "./index.css";
import { BrowserRouter } from "react-router-dom";
import { MusicProvider } from "./contexts/MusicContext.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <MusicProvider>
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </MusicProvider>
  </React.StrictMode>
);
