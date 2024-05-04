import React, { useState } from "react"
import style from "./MyProblemsPage.module.scss"

export const MyProblemsPage = () => {
  const getUserByID = (user_id) => {
    const res = {
      id: 1,
      email: "tolstovrob@gmail.com",
      telegram: "https://t.me/im_robertproducts",
      vk: "https://vk.com/robertproducts",
      photo: "public/img/defaultUser.webp",
      name: "Роберт",
      surname: "Толстов"
    }
    return res
  }

  const handleSendSolution = (event) => {
    alert("Чёта случилось")
  }

  const [problemsList, setProblemsList] = useState([
    {
      id: 1,
      description: "Мусорная помойка около двенадцатого корпуса СГУ",
      photo: "public/img/defaultUser.webp",
      lat: 54.3,
      lon: 234.23456,
      author_id: 1,
      solved_id: null,
      solution_photo: null,
      state: "free",
    },
    {
      id: 2,
      description: "Голубиный помёт около районной поликлиники",
      photo: "public/img/defaultUser.webp",
      lat: 35.3,
      lon: 234.23456,
      author_id: 1,
      solved_id: 2,
      solution_photo: "public/img/defaultUser.webp",
      state: "free",
    },
    {
      id: 3,
      description: "Моя хата с краю",
      photo: "public/img/defaultUser.webp",
      lat: 54.3,
      lon: 234.23456,
      author_id: 2,
      solved_id: null,
      solution_photo: null,
      state: "free",
    }
  ])

  return (
    <section>
        <h1>Мои проблемы</h1>
        <h6>Волонтёры откликнутся на ваш вызов!</h6>

        <div className={style["problems-wrapper"]}>
          {problemsList.map(problem => (problem.author_id === 1) &&
            <div className={style.card}>
              <div className={style["task-part"]}>
                <div className={style.photo}>
                  <img src={problem.photo} />
                </div>
                <div>
                  <h2>{problem.description}</h2>
                  <div><b>Обнаружил:</b> {getUserByID(problem.author_id).name} {getUserByID(problem.author_id).surname}</div>
                  <div><b>Координаты:</b> {problem.lat} {problem.lon}</div>
                  <button onClick={handleSendSolution}>
                    Заявить о решении
                  </button>
                </div>
              </div>
              <hr />
              {problem.solved_id && <div className={style["solution-part"]}>
                <div className={style.photo}>
                  <img src={problem.photo} />
                </div>
                <div>

                </div>
              </div>}
            </div>
          )}
        </div>
    </section>
  )
}
