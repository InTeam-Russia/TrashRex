import React, { useRef, useState, useEffect } from "react"
import { YMaps, Map, GeolocationControl, RulerControl, TrafficControl, TypeSelector, ZoomControl, Placemark, Clusterer } from "@pbe/react-yandex-maps";
import style from "./ProblemPoint.module.scss"
import { problemsList } from "../../utils/problems"
import ReactDOMServer from 'react-dom/server'
import { createRoot } from 'react-dom/client';
import { StrictMode } from "react";
import ModalAlert from '../ModalAlert/ModalAlert'


const ProblemPoint = ({index, problem, user}) => {
  const [problemState, setProblem] = useState(problem)
  const [takeButtonState, setTakeButtonState] = useState(true)
  const [solveButtonState, setSolveButtonState] = useState(false)
  const [waitingState, setWaitingState] = useState(false)
  const [modalShown, setModalVisibility] = useState({
    visible: false
  });
  
  const onTakeWork = () => {
    if(!user) {
      window.location.pathname = "/authreg"
      return;
    }
    setTakeButtonState(false)
    setSolveButtonState(true)
  }

  const onSolveWork = () => {
    setModalVisibility({
      visible: true
    })
  }

  const solveWork = () => {
    setSolveButtonState(false)
    setModalVisibility({
      visible: false
    })
    setWaitingState(true)
  }

  const balloon = <>
    <div className={`driver-card ${style['driver-card']}`}>
          <div className={style['card-wrapper']}>
          <img src={problemState.photo} width="400" height="192" style={{objectFit: "cover"}} />
          <h2>{problemState.description}</h2>
          <button className={`${!takeButtonState ? style.hidden : ''} ${style.button}`} onClick={() => {onTakeWork()}} >
          Заняться решением проблемы
          </button>
          <button className={`${!solveButtonState ? style.hidden : ''} ${style.button}`} onClick={() => {onSolveWork()}} >
          Проблема решена
          </button>
          <p className={`${!waitingState ? style.hidden : ''}`}>Ожидаем, когда сообщивший о проблеме человек проверит Ваш фотоотчёт...</p>
          </div>
    </div>
  </>;

  const getBalloonContent = (e) => {
      const elm = document.getElementById(index + '-balloon')
      if(elm) {
        console.log(elm)
        const root = createRoot(elm)
        root.render(<StrictMode>
          {balloon}
        </StrictMode>)
      }
  }

  return (
    <>
        <Placemark options={{iconColor: "#0000ff",
                                preset: "pinIcon"}}
                    key={index} geometry={[problemState.lat, problemState.lon]}
                    properties={{iconContent: `<b>!</b>`,
                                hintContent: `<b>${problemState.lat} ${problemState.lat}</b>`,
                                balloonContent: `<div id="${index}-balloon" class="${style.ballon}"></div>`,}} onClick={getBalloonContent} />
        {getBalloonContent()}
        <ModalAlert icon="material-symbols:image" closable="true" header="Загрузите фотоотчёт" body={(<>Загрузите фотоотчёт: <input type="file" /></>)} onClick={() => solveWork()} buttonText="Отправить" {...modalShown} state={modalShown} />
    </>
  )
  /*
  `<div id="driver-2" class="driver-card ${style["driver-card"]}">
                                    <div class=${style["card-wrapper"]}>
                                    <img src="${problemState.photo}" width="400" height="192" style="object-fit: cover" />
                                    <h2>${problemState.description}</h2>
                                    <button class="${style.button}" onclick="alert("TES");">
                                    Заняться решением проблемы
                                    </button>
                                    </div>
                                </div>`
  */
 /* <div className={`driver-card ${style['driver-card']}`}>
          <div className={style['card-wrapper']}>
          <img src={problemState.photo} width="400" height="192" style="object-fit: cover" />
          <h2>{problemState.description}</h2>
          <button className={style.button} onClick="alert('TES\');">
          Заняться решением проблемы
          </button>
          </div>
      </div> */
}

export default ProblemPoint