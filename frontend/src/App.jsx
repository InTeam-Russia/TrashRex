import { BrowserRouter, Route, Routes, Navigate } from "react-router-dom"
import Navbar from "./components/Navbar/Navbar"
import AuthregPage from "./pages/AuthregPage/AuthregPage"
import MapPage from "./pages/MapPage/MapPage"
import { useEffect, useState } from "react"
import { useLocation } from "react-router-dom"
import { MyProblemsPage } from "./pages/MyProblemsPage/MyProblemsPage"

const App = () => {
  const [user, setUser] = useState({
    id: 1,
    email: "tolstovrob@gmail.com",
    telegram: "https://t.me/im_robertproducts",
    vk: "https://vk.com/robertproducts",
    photo: "public/img/defaultUser.webp",
    name: "Роберт",
    surname: "Толстов"
  })

  const location = useLocation()

  const getCurrentUser = () => {
    // await fetch("http://10.1.0.101:8000/auth/whoami")
    // .then((response) => {
    //   return new Promise((response) => resolve({
    //       status: response.status,
    //       ok: response.ok,
    //       response,
    //     })));
    // }).then(({ status, response, ok }) => {
    //   if(ok) {
    //     setUser(await response.json())
    //   }
    // })
  }

  return (
    <main>
      <Navbar user={user} setUser={setUser} />
      <div className="app-wrapper">
        <Routes>
          <Route path="/authreg" element={<AuthregPage />} />
          <Route path="/map" element={<MapPage />} />
          <Route path="/" element={<MapPage />} />
          <Route path="/problems" element={<MyProblemsPage />} />
          <Route path="/profile" element={<AuthregPage />} />
        </Routes>
      </div>
    </main>
  )
}

export default App
