import React from 'react'
import { Icon } from "@iconify/react"
import style from "./Navbar.module.scss"

const Navbar = ({ user, setUser }) => {
  const tabsList = [
  {
      route: "/map",
      name: "Карта",
      icon: "jam:map",
    },
    {
      route: "/problems",
      name: "Мои проблемы",
      icon: "material-symbols:report-outline",
    },
    {
      route: "/tasks",
      name: "Мои задачи",
      icon: "bx:task",
    }
  ]
  
  return (
    <nav className={style.navbar}>
        <a href="/" className={style.brand}>
          <span className={style.icon}>
              <Icon icon="fluent:bin-recycle-full-24-filled" width="1em" height="1em"/>
          </span>
          <span>
              TrashRex
          </span>
        </a>
        <ul className={style.tabs}>
        {tabsList.map(tab => <a href={tab.route} className={style.tab}>
            <span className={style.icon}>
                <Icon icon={tab.icon} width="1em" height="1em" />
            </span>
            <span>
                {tab.name}
            </span>
            </a>)}
          <a href="/profile" className={style.tab}>
              <span className={style.icon}>
                <Icon icon="fluent:person-star-32-filled" width="1em" height="1em" />
              </span>
              <span>
                  {user ? `${user.name} ${user.surname}` : "Войти"}
              </span>
            </a>
        </ul>
    </nav>
  )
}

export default Navbar
