import { BrowserRouter, Route, Routes } from "react-router-dom"
import Navbar from "./components/Navbar/Navbar"
import AuthregPage from "./pages/AuthregPage/AuthregPage"
import MapPage from "./pages/MapPage/MapPage"
import { useEffect, useState } from "react"
import { useLocation } from "react-router-dom"
import { ProfilePage } from "./pages/ProfilePage/ProfilePage"
import { LandingPage } from "./pages/LandingPage/LandingPage"

const App = () => {
  const [user, setUser] = useState(null)
  const location = useLocation()

  const getCurrentUser = async () => {
    const response = await fetch("http://localhost:8000/auth/whoami", {
      credentials: 'include',
    })
    .then((res) => {
      return res.ok ? res.json() : false
    })
    .catch(() => {
      return false
    })
    return response
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
          <Route path="/map" element={<MapPage user={user} setUser={setUser} />} />
          {user ?
          <>
            <Route path="/" element={<LandingPage />} />
            <Route path="/about" element={<LandingPage />} />
            <Route path="/profile" element={<ProfilePage curuser={user} />} />
          </>
          :
          <>
            <Route path="/" element={<LandingPage />} />
            <Route path="/authreg" element={<AuthregPage />} />
          </>
          }
        </Routes>
      </div>
    </main>
  )
}

export default App
