import React, { useEffect, useState } from "react"
import style from "./ProfilePage.module.scss"

export const ProfilePage = ({ curuser }) => {
  const [user, setUser] = useState(curuser)
  const [newUser, setNewUser] = useState(curuser)
  const [diff, setDiff] = useState(false)
  const [userStats, setUserStats] = useState({
      promlems_added: 16,
      problems_solved: 14,
      events_added: 1,
      events_visited: 5,
      exp: 1245,
      level: 16,
    })
  const [formValidate, setFormValidate] = useState({
    isPasswordsMatch: true,
    isVkOrTg: true,
  })

  const handleSubmit = () => {
    setFormValidate(({ prev }) => ({
      isVkOrTg: (newUser.vk + newUser.telegram !== ""),
    }))

    alert("Абоба")
  }

  useEffect(() => {
    setDiff(Object.values(user) !== Object.values(newUser)) // TODO: Пофиксить!
  }, [user, newUser])

  return (
  <header className={style.header}>
    <div>
      <img className={style.userphoto} src={process.env.PUBLIC_URL + `${user.photo}`} />
      <div className={style.statswrapper}>
        <h1>{user.name} {user.surname}</h1>
        <ul className={style.stats}>
          <li><b>Добавлено проблем: </b>{userStats.promlems_added}</li>
          <li><b>Решено проблем: </b>{userStats.problems_solved}</li>
          <li><b>Добавлено событий: </b>{userStats.events_added}</li>
          <li><b>Посещено событий: </b>{userStats.events_visited}</li>
          <li><b>Опыт: </b>{userStats.exp}</li>
          <li><b>Уровень: </b>{userStats.level}</li>
        </ul>
      </div>
    </div>
    <form method="post" onSubmit={handleSubmit} className={style.form}>
      <h1>Настроить профиль</h1>
      <input type="email" value={newUser.email} onChange={(event) => { setNewUser({ ...newUser, email: event.target.value }) }} required placeholder="Электронная почта" className={style.text} />
          <input type="text" value={newUser.name} onChange={(event) => { setNewUser({ ...newUser, name: event.target.value }) }} required placeholder="Имя" className={style.text} />
          <input type="text" value={newUser.surname} onChange={(event) => { setNewUser({ ...newUser, surname: event.target.value }) }} required placeholder="Фамилия" className={style.text} />
          <input type="text" value={newUser.telegram} onChange={(event) => { setNewUser({ ...newUser, telegram: event.target.value }) }} placeholder="Хендл Telegram (@im_robertroducts)" className={style.text} />

          <input type="text" value={newUser.vk} onChange={(event) => { setNewUser({ ...newUser, vk: event.target.value }) }} placeholder="Либо хендл ВК (@danilasar)" className={style.text} />
          <span className={`${style.error} ${formValidate.isVkOrTg ? style.hidden : ""}`}>
            Введите хотя бы одну социальную сеть
          </span>
        <input type="submit" value={"Изменить"} onClick={(event) => {
          event.preventDefault()
          handleSubmit()
        }} />
    </form>
    </header>
    
  )
}
