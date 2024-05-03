<script>
    import Navbar from "../components/Navbar/Navbar.svelte";
</script>

<main>
    <Navbar />
    <slot />
</main>

<style lang="scss">
    @import "../app.scss";
</style>