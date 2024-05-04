import React, {useState, useRef} from 'react'
import {
    YMaps,
    Map,
    ZoomControl,
    SearchControl,
    GeolocationControl,
    RulerControl,
    TypeSelector,
    Clusterer, Placemark,
    TrafficControl,
    withYMaps, Button
} from "@pbe/react-yandex-maps"
import style from "./MapPage.module.scss"
import App from "../../App.jsx";

export const MapPage = () => {
    const [clusterPoints, setClusterPoints] = useState([
        [55.751574, 37.573856],
        [56.751574, 37.573856],
        [55.751574, 38.573856]
    ])
    const [map, setMapState] = useState({
        defaultState: {center: [55.75, 37.57], zoom: 15},
        className: style.map
    })
    const mapRef = useRef(null);

    const LengthPrinter = React.useMemo(() => {
        return ({ ymaps, route }) => {
            const [routeLength, setRouteLength] = React.useState(null);
            React.useEffect(() => {
                let canceled = false;
                if (ymaps && ymaps.route) {
                    ymaps.route(route).then((route) => {
                        if (!canceled) {
                            setRouteLength(route.getHumanLength().replace('&#160;', ' '));
                        }
                    });
                }
                return () => (canceled = true);
            }, [ymaps, ...route]);

            return routeLength ? (
                <p>
                    The route from <strong>{route[0]}</strong> to{' '}
                    <strong>{route[1]}</strong> is <strong>{routeLength}</strong> long
                </p>
            ) : (
                <p>Loading route...</p>
            );
        };
    }, []);

    const ConnectedLengthPrinter = React.useMemo(() => {
        return withYMaps(LengthPrinter, true, ['route']);
    }, [LengthPrinter]);

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

    const addPoint = () => {
        console.log("Point")
        console.log(map)
        setClusterPoints(() => [...clusterPoints, [10, 20]])
    }

    return (
        <>
            <YMaps className={style.ymaps} query={{ lang: 'ru_RU', apikey: 'ae7af7e4-21ba-424c-8434-23281d1da074' }}>
                <>
                    <div ref={mapRef}>
                        <Map className={style.map} defaultState={{center: [55.75, 37.57], zoom: 15}} instanceRef={map} >
                            <ZoomControl options={{float: "right"}}/>
                            <SearchControl options={{float: "right"}}/>
                            <GeolocationControl options={{float: "left"}}/>
                            <RulerControl options={{float: "right"}}/>
                            <TypeSelector options={{float: "right"}}/>
                            <TrafficControl options={{float: "right"}}/>
                            <Button
                                options={{ maxWidth: 128 }}
                                data={{ content: "Unpress me!" }}
                                defaultState={{ selected: true }}
                            />
                            <Clusterer
                                options={{
                                    preset: "islands#invertedDarkGreenClusterIcons",
                                    groupByCoordinates: false,
                                }}
                            >
                                {clusterPoints.map((coordinates, index) => (
                                    <Placemark key={index} geometry={coordinates}/>
                                ))}
                            </Clusterer>

                            {/*<ConnectedLengthPrinter route={['Moscow, Russia', 'Berlin, Germany']} />*/}
                        </Map>
                    </div>
                    <div className={style.marker}></div>
                    <button onClick={addPoint}>Добавить точку</button>
                </>
            </YMaps>
        </>

    )
}

export default MapPage
