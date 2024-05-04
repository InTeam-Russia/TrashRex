import React, { useState } from "react"
import style from "./AuthregPage.module.scss"

const AuthregPage = () => {
  const emailRegex = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$/
  const vkRegex = /^https:\/\/vk\.com\/[a-zA-Z0-9_]+$/
  const tgRegex = /^https:\/\/t\.me\/[a-zA-Z0-9_]+$/

  const [isAuth, setIsAuth] = useState(true)
  const [authForm, setAuthForm] = useState({
    email: "",
    password: ""
  })

  const [regForm, setRegForm] = useState({
    name: "",
    surname: "",
    imgSrc: "img/defaultUser.webp",
    telegram: "",
    vk: "",
    password: "",
    repeatedPassword: "",
  })

  const [regFormValidate, setRegFormValidate] = useState({
    isVkPattern: true,
    isTgPattern: true,
    isPasswordsMatch: true,
    isVkOrTg: true,
  })

  const validateForm = () => {
    let flag = true
    if (isAuth) return !flag
    setRegFormValidate(({...prev}) => ({prev, isVkPattern: vkRegex.test(regForm.vk)}))
    flag = flag && vkRegex.test(regForm.vk)
    setRegFormValidate(({...prev}) => ({prev, isTgPattern: tgRegex.test(regForm.telegram)}))
    flag = flag && tgRegex.test(regForm.telegram)
    setRegFormValidate(({...prev}) => ({prev, isPasswordsMatch: (regForm.password === regForm.repeatedPassword)}))
    flag = flag && (regForm.password === regForm.repeatedPassword)
    setRegFormValidate(({...prev}) => ({prev, isVkOrTg: (regForm.vk + regForm.telegram !== "")}))
    flag = flag && (regForm.vk + regForm.telegram !== "")
    
    return flag
  }

  const handleSubmit = (event) => {
    if (!validateForm()) return
    
    if (isAuth) { 
      const res = {...authForm}
      alert(JSON.stringify(res))

      fetch("http://10.1.0.101:8000/user/login", {
        method: "POST",
        body: JSON.stringify(res),
        headers: {
          "Content-Type": "application/json"
        }
      })
      .then(response => response.json())
      .catch(() => {alert("Ошибка сервера, попробуйте позднее")})
    } else {
      const res = {
        email: regForm.email,
        password: regForm.password,
        name: regForm.name ? regForm.name : null,
        surname: regForm.surname ? regForm.surname : null,
        is_active: true,
        is_superuser: false,
        is_verified: false,
        vk: regForm.vk ? regForm.vk : null,
        telegram: regForm.telegram ? regForm.telegram : null,
      }
      alert(JSON.stringify(res))


      fetch("http://10.1.0.101:8000/user/register", {
        method: "POST",
        body: JSON.stringify(res),
        headers: {
          "Content-Type": "application/json"
        }
      })
      .then(response => response.json())
      .catch(() => {alert("Ошибка сервера, попробуйте позднее")})
    }
  }

  return (
  <section>
    <h1 className={style.h1}>
      <span class={isAuth && style.active} onClick={() => {setIsAuth(true)}}>Вход</span>
      <span class={!isAuth && style.active} onClick={() => {setIsAuth(false)}}>Регистрация</span>
    </h1>
    <form method="post" onSubmit={handleSubmit} className={style.form}>
      {isAuth
        ? <><input type="email" value={authForm.email} onChange={(event) => {setAuthForm({...authForm, email: event.target.value})}} required placeholder="Электронная почта" className={style.text} />
            <input type="password" value={authForm.password} onChange={(event) => {setAuthForm({...authForm, password: event.target.value})}} required placeholder="Пароль" className={style.text} /></>
        : <><input type="email" value={regForm.email} onChange={(event) => {setRegForm({...regForm, email: event.target.value})}} required placeholder="Электронная почта" className={style.text} />
            <input type="text" value={regForm.name} onChange={(event) => {setRegForm({...regForm, name: event.target.value})}} required placeholder="Имя" className={style.text} />
            <input type="text" value={regForm.surname} onChange={(event) => {setRegForm({...regForm, surname: event.target.value})}} required placeholder="Фамилия" className={style.text} />
            <input type="text" value={regForm.vk} onChange={(event) => {setRegForm({...regForm, vk: event.target.value})}} placeholder="ВК (ссылка на профиль)" className={style.text} />
            <span class={`${style.error} ${regFormValidate.isVkPattern ? style.hidden : ""}`}>
              Ссылка не удовлетворяет формату https://vk.com/example
            </span>
            <input type="text" value={regForm.telegram} onChange={(event) => {setRegForm({...regForm, telegram: event.target.value})}} placeholder="Telegram (ссылка на профиль)" className={style.text} />
            <span class={`${style.error} ${regFormValidate.isTgPattern ? style.hidden : ""}`}>
              Ссылка не удовлетворяет формату https://t.me/example
            </span>
            <input type="password" value={regForm.password} onChange={(event) => {setRegForm({...regForm, password: event.target.value})}} required placeholder="Пароль" className={style.text} />
            <input type="password" value={regForm.repeatedPassword} onChange={(event) => {setRegForm({...regForm, repeatedPassword: event.target.value})}} required placeholder="Повтор пароля" className={style.text} />
            <span class={`${style.error} ${regFormValidate.isPasswordsMatch ? style.hidden : ""}`}>
              Пароли не совпадают
            </span>
            <span class={`${style.error} ${regFormValidate.isVkOrTg ? style.hidden : ""}`}>
              Введите хотя бы одну социальную сеть
            </span></>}
      <div>
        <input type="submit" value={isAuth ? "Войти" : "Зарегистрироваться"} onClick={(event) => {
          event.preventDefault()
          handleSubmit()
        }} />  
        <input type="reset" value="Сбросить" />  
      </div>
    </form>
  </section>
)}

export default AuthregPage
