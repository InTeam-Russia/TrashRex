<script>
    import Icon from "@iconify/svelte"

    const tabsList = [
        {
            route: "/map",
            name: "Карта",
            icon: "jam:map",
        },
        {
            route: "/problems",
            name: "Мои проблемы",
            icon: "ic:round-report-problem",
        },
        {
            route: "/tasks",
            name: "Мои задачи",
            icon: "bx:task",
        }
    ]
</script>

<nav>
    <ul class="tabs">
        {#each tabsList as tab}
            <a href={tab.route}><Icon icon={tab.icon} width="1em" height="1em" />{tab.name}</a>
        {/each}
    </ul>
</nav>

<style lang="scss">
    @import "./Navbar.scss";
    @import "./Navbar.mobile.scss";
</style>