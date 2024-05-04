import React, { useRef, useState, useEffect } from "react"
import { YMaps, Map, GeolocationControl, RulerControl, TrafficControl, TypeSelector, ZoomControl, Placemark, Clusterer } from "@pbe/react-yandex-maps";
import style from "./MapPage.module.scss"
import { problemsList } from "../../utils/problems"

const MapPage = () => {
  const [coord, setCoord] = useState([51.529617326918846, 46.043731689453146])
  const [problems, setProblems] = useState(problemsList.map(problem => ({
    description: problem.description,
    photo: problem.photo,
    lat: problem.lat,
    lon: problem.lon
  })))
  const [placemarks, setPlaceMarks] = useState(problemsList.map(problem => [problem.lat, problem.lon]))
  const [activePortal, setActivePortal] = useState(false)

  // const getCurrentPlacemarks = () => {
  //   fetch("http://10.1.0.101:8000/problems/all_free")
  //   .then(res => res.json())
  //   .then(res => {setProblems(res)})
  //   .then(res => {setPlaceMarks(res.map(item => [item.lat, item.lon]))})
  //   .catch(() => {alert("Ошибка сервера, попробуйте позднее")})
  // }

  // useEffect(() => {
  //   const asyncGetCurrentPlacemarks = async () => {
  //     getCurrentPlacemarks()
  //   }
  // }, [])

  const handleAddProblem = () => {
    const description = prompt("Введите описание проблемы:")
    if (!description) return
    try {
      setProblems(() => [...problems, {
        description: description,
        photo: `img/problems/${Math.floor(Math.random()*4)+1}.jpg`,
        lat: coord[0],
        lon: coord[1]
      }])
      alert(`Проблема "${description}" добавлена по координатам: ${coord[0]} ${coord[1]}`)
    } catch {
      alert("Произошла ошибка, попробуйте позже")
    }
  }

  const handleSendSolution = (event) => {
    alert("Вы решили проблему!")
  }

  function onActionTickComplete(e) {
    const projection = e.get("target").options.get("projection");
    const { globalPixelCenter, zoom } = e.get("tick");
    setCoord(projection.fromGlobalPixels(globalPixelCenter, zoom));
  }

  return (
    <>
    <button onClick={handleAddProblem} className={style["float-button"]} >
      +
    </button>
    <div className={style.ymaps}>
      <YMaps query={{ lang: "ru_RU", apikey: "ae7af7e4-21ba-424c-8434-23281d1da074" }}>
        <div>
          <h1 className={style.placeholder}>Ожидайте загрузки карты</h1>
          <Map onActionTickComplete={onActionTickComplete} className={style.map}
               defaultState={{ center: coord, zoom: 15 }}
               modules={ [ 'geoObject.addon.balloon', 'geoObject.addon.hint' ] }>
          <GeolocationControl options={{ float: "left" }} />
          <RulerControl options={{ float: "right" }} /> 
          <TrafficControl options={{ float: "right" }} />
          <TypeSelector options={{ float: "right" }} />
          <ZoomControl options={{ float: "right" }} />

          <Placemark options={{iconColor: "#ff0000", preset: "islands#redPinIcon"}} geometry={coord} />
          <Clusterer>
          {problems.map((problem, index) => (
            <Placemark options={{iconColor: "#0000ff",
                                 preset: "pinIcon"}}
                       onClick={setTimeout(() => { setActivePortal(true)}, 0)} key={index} geometry={[problem.lat, problem.lon]}
                       properties={{iconContent: `<b>!</b>`,
                                    hintContent: `<b>${problem.lat} ${problem.lat}</b>`,
                                    balloonContent: `<div id="driver-2" class="driver-card ${style["driver-card"]}">
                                      <div class=${style["card-wrapper"]}>
                                      <img src="${problem.photo}" width="400" height="192" style="object-fit: cover" />
                                      <h2>${problem.description}</h2>
                                      <button class=${style.button} onclick="alert("TES");">
                                        Заняться решением проблемы
                                      </button>
                                      </div>
                                    </div>`,}} />
          ))}
          </Clusterer>
          </Map>
        </div>
      </YMaps>
    </div>
    </>
  )
}

export default MapPage