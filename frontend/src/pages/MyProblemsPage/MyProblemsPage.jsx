import React, { useState } from "react"
import style from "./MyProblemsPage.module.scss"
import { problemsList } from "../../utils/problems"

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

  const [problemsList, setProblemsList] = useState(problemsList)

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
