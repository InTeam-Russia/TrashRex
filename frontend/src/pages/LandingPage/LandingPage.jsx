import React from 'react'
import style from "./LandingPage.module.scss"
import AOS from "aos"
import "aos/dist/aos.css"

AOS.init({
  duration: 125,
  once: true,
  easing: "ease-out",
})

export const LandingPage = () => {
  return (
    <>
      <header className={style.header}>
        <img src="img/logo.png" data-aos="fade-left" />
        <div>
          <h1 data-aos="fade-up">TrashRex. Экология. Чистота. Культура.</h1>
          <div>
            TrashHack - это система, где вы можете помочь людям спасти планету. Сообщите о проблеме или помогите решить уже существующие. Наша цель - максимальное снижение актуальности нашего приложения, как бы парадоксально это ни звучало.
          </div>
        </div>
      </header>
    </>
  )
}
