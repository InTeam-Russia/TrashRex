import React, { useState } from 'react'
import { Icon } from "@iconify/react"
import style from "./Navbar.module.scss"

const Navbar = () => {
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

  const [user, setUser] = useState(null)
  
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
        </ul>
        &nbsp;
        <div className="user">
        {user ? <span>Залогинен</span> : <span>Незалогинен</span>}
        </div>
    </nav>
  )
}

export default Navbar
