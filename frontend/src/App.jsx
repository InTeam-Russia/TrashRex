import { BrowserRouter, Route, Routes } from "react-router-dom"
import Navbar from "./components/Navbar/Navbar"
import AuthregPage from "./pages/AuthregPage/AuthregPage"
import MapPage from "./pages/MapPage/MapPage"
import { useEffect, useState } from "react"
import { useLocation } from "react-router-dom"

const App = () => {
  const [user, setUser] = useState(null)
  const location = useLocation()

  const getCurrentUser = async () => {
    return await fetch("http://10.1.0.101:8000/auth/whoami")
    .then((res) => {
      return res.ok ? res.json() : false
    })
    .catch(() => {
      alert("Ошибка сервера, извините :(")
      return false
    })
  }

  useEffect(() => {
    const asyncGetCurrentUser = async () => {
      setUser(await getCurrentUser())
    }
    asyncGetCurrentUser()
  }, [location])

  return (
    <main>
      <Navbar user={user} setUser={setUser} />
      <div className="app-wrapper">
        <Routes>
          <Route path="/authreg" element={<AuthregPage />} />
          <Route path="/map" element={<MapPage />} />
          <Route path="/" element={<MapPage />} />
        </Routes>
      </div>
    </main>
  )
}

export default App
