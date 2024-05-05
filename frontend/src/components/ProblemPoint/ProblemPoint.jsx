import React, { useRef, useState, useEffect } from "react"
import { YMaps, Map, GeolocationControl, RulerControl, TrafficControl, TypeSelector, ZoomControl, Placemark, Clusterer } from "@pbe/react-yandex-maps";
import style from "./ProblemPoint.module.scss"
import { problemsList } from "../../utils/problems"
import ReactDOMServer from 'react-dom/server'
import { createRoot } from 'react-dom/client';
import { StrictMode } from "react";


const ProblemPoint = ({index, problem, user}) => {
  const [problemState, setProblem] = useState(problem)
  
  const onTakeWork = () => {
    if(!user) {
      window.location.pathname = "/authreg"
      return;
    }

  }

  const balloon = <>
    <div className={`driver-card ${style['driver-card']}`}>
          <div className={style['card-wrapper']}>
          <img src={problemState.photo} width="400" height="192" style={{objectFit: "cover"}} />
          <h2>{problemState.description}</h2>
          <button className={style.button} onClick={() => {onTakeWork()}}>
          Заняться решением проблемы
          </button>
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