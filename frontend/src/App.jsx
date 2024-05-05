import { BrowserRouter, Route, Routes } from "react-router-dom"
import Navbar from "./components/Navbar/Navbar"
import AuthregPage from "./pages/AuthregPage/AuthregPage"
import MapPage from "./pages/MapPage/MapPage"
import AboutPage from "./pages/AboutPage/AboutPage"
import { useEffect, useState } from "react"
import { useLocation } from "react-router-dom"
import { ProfilePage } from "./pages/ProfilePage/ProfilePage"

const App = () => {
  const [user, setUser] = useState({
    email: "tolstovrob@gmail.com",
    photo: "/img/defaultUser.webp",
    telegram: "im_robertproducts",
    vk: "robertproducts",
    name: "Robert",
    surname: "Tolstov",
  })
  const location = useLocation()

  // const getCurrentUser = async () => {
  //   const response = await fetch("http://localhost:8000/auth/whoami", {
  //     credentials: 'include',
  //   })
  //   .then((res) => {
  //     return res.ok ? res.json() : false
  //   })
  //   .catch(() => {
  //     return false
  //   })
  //   return response
  // }

  // useEffect(() => {
  //   const asyncGetCurrentUser = async () => {
  //     setUser(await getCurrentUser())
  //   }
  //   asyncGetCurrentUser()
  // }, [location])

  return (
    <main>
      <Navbar user={user} setUser={setUser} />
      <div className="app-wrapper">
        <Routes>
          {user ?
          <>
            <Route path="/" element={<MapPage user={user} setUser={setUser} />} />
            <Route path="/about" element={<AboutPage />} />
            <Route path="/map" element={<MapPage user={user} setUser={setUser} />} />
            <Route path="/profile" element={<ProfilePage curuser={user} />} />
          </>
          :
          <>
            <Route path="/" element={<AboutPage />} />
            <Route path="/map" element={<MapPage user={user} setUser={setUser} />} />
            <Route path="/authreg" element={<AuthregPage />} />
          </>
          }
        </Routes>
      </div>
    </main>
  )
}

export default App
