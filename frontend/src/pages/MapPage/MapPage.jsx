import React, { useState } from 'react'
import { YMaps,
         Map,
         ZoomControl,
         SearchControl,
         GeolocationControl,
         RulerControl,
         TypeSelector,
         Clusterer,Placemark,
         TrafficControl } from "@pbe/react-yandex-maps"
import style from "./MapPage.module.scss"

export const MapPage = () => {
  const [clusterPoints, setClusterPoints] = useState([
    [55.751574, 37.573856],
    [56.751574, 37.573856],
    [55.751574, 38.573856]
  ])

  const getClusterPoints = async () => (
    await fetch("http://10.1.0.101:8000/problems/all_free")
    .then(res => res.json())
    .then(
      () => {
        let finalRes = []
        Object.keys(res).forEach((key, index) => {
            finalRes.push([res[key].lat, res[key].lon])
          })
      }
    )
    .catch()
  ) 

  return (
    <>
    <YMaps className={style.ymaps}>
      <Map className={style.map} defaultState={{ center: [55.75, 37.57], zoom: 15 }}>
        <ZoomControl options={{ float: "right" }} />
        <SearchControl options={{ float: "right" }} />
        <GeolocationControl options={{ float: "left" }} />
        <RulerControl options={{ float: "right" }} />
        <TypeSelector options={{ float: "right" }} />
        <TrafficControl options={{ float: "right" }} />

        <Clusterer
          options={{
            preset: "islands#invertedDarkGreenClusterIcons",
            groupByCoordinates: false,
          }}
        >
          {clusterPoints.map((coordinates, index) => (
            <Placemark key={index} geometry={coordinates} />
          ))}
        </Clusterer>
      </Map>
    </YMaps>
    </>
    
  )
}

export default MapPage
