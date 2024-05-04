import { BrowserRouter, Route, Routes } from "react-router-dom"
import Navbar from "./components/Navbar/Navbar"
import AuthregPage from "./pages/AuthregPage/AuthregPage"


const App = () => {
  return (
    <main>
      <BrowserRouter>
      <Navbar />
        <Routes>
          <Route path="/authreg" element={<AuthregPage />} />
        </Routes>
    </BrowserRouter>
    </main>
  )
}

export default App
