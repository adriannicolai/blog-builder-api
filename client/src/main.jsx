import React from "react"
import ReactDOM from "react-dom/client"
import App from "./App"
import "tailwindcss/tailwind.css"
import { createBrowserRouter, RouterProvider } from "react-router-dom"
import ErrorPage from "./components/errors/ErrorPage.jsx"
import Backend from "./components/defaults/backend.jsx"

const router = createBrowserRouter([
  {
    path: "/",
    element: <App/>,
    errorElement: <ErrorPage/>,
  },
  {
    path: "dashboard",
    element: <Backend/>,
  },
])

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <RouterProvider router={router}/>
  </React.StrictMode>,
)
