import React, { useRef, useState, useEffect } from 'react'
import { YMaps, Map, GeolocationControl, RulerControl, TrafficControl, TypeSelector, ZoomControl, Placemark, Clusterer } from '@pbe/react-yandex-maps';
import style from "./MapPage.module.scss"
import { problemsList } from '../../utils/problems';

const MapPage = () => {
  const [ coord, setCoord ] = useState([51.32, 46])

  const [ placemarks, setPlaceMarks ] = useState(problemsList.map(item => [item.lat, item.lon]))

  // const getCurrentPlacemarks = async () => {
  //   const response = await problemsList //fetch("http://10.1.0.101:8000/problems/all_free")
  //   .then((res) => {
  //     return res.ok ? res.json() : false
  //   })
  //   .then((res) => {
  //     let newRes = []
  //     res.forEach(jsonitem => {
  //       newRes.push([jsonitem.lat, jsonitem.lon])
  //     })
  //     return newRes
  //   })
  //   .catch(() => {
  //     return false
  //   })
  //   return response
  // }

  // useEffect(() => {
  //   const asyncGetPlacemarks = async () => {
  //     setPlaceMarks(await getCurrentPlacemarks())
  //   }
  //   asyncGetPlacemarks()
  // }, [])

  const handleAddProblem = () => {
    const description = prompt("Введите описание проблемы:")
    try {
      setPlaceMarks(() => [...placemarks, coord])
      alert(`Проблема "${description}" добавлена по координатам: ${coord[0]} ${coord[1]}`)
    } catch {
      alert("Произошла ошибка, попробуйте позже")
    }
  }

  const handlePlacemarkClick = (event) => {
    alert(event.get("target").geometry)
  }

  //ferfr

  function onActionTickComplete(e) {
    const projection = e.get('target').options.get('projection');
    const { globalPixelCenter, zoom } = e.get('tick');
    setCoord(projection.fromGlobalPixels(globalPixelCenter, zoom));
  }

  return (
    <>
    <button onClick={handleAddProblem} className={style["float-button"]} >
      +
    </button>
    <div className={style.ymaps}>
      <YMaps query={{ lang: 'en_RU', apikey: "ae7af7e4-21ba-424c-8434-23281d1da074" }}>
        <div>
          <Map onActionTickComplete={onActionTickComplete} className={style.map} defaultState={{ center: coord, zoom: 15 }}>
          <GeolocationControl options={{ float: "left" }} />
          <RulerControl options={{ float: "right" }} /> 
          <TrafficControl options={{ float: "right" }} />
          <TypeSelector options={{ float: "right" }} />
          <ZoomControl options={{ float: "right" }} />

          <Placemark options={{iconColor: "#ff0000"}} geometry={coord} />
          <Clusterer>
          {placemarks.map((coord, index) => (
            <Placemark onClick={handlePlacemarkClick} key={index} geometry={coord} />
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