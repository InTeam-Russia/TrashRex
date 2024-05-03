<svelte:head>
    <script src="https://api-maps.yandex.ru/v3/?apikey=ae7af7e4-21ba-424c-8434-23281d1da074&lang=ru_RU"></script>
</svelte:head>

<script>
async function initMap() {
    await ymaps3.ready;

    const {YMap, YMapDefaultSchemeLayer} = ymaps3;

    const map = new YMap(
        document.getElementById('app'),
        {
            location: {
                center: [37.588144, 55.733842],
                zoom: 10
            }
        }
    );

    map.addChild(new YMapDefaultSchemeLayer());
}

initMap();
</script>

<section>
<div id="map"></div>
</section>

<style>

</style>