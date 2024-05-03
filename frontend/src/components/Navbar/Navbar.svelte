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
            icon: "material-symbols:report-outline",
        },
        {
            route: "/tasks",
            name: "Мои задачи",
            icon: "bx:task",
        }
    ]

    let user = null
</script>

<nav>
    <a href="/" class="brand">
        <span class="icon">
            <Icon icon="fluent:bin-recycle-full-24-filled" width="1em" height="1em"/>
        </span>
        <span>
            TrashRex
        </span>
    </a>
    <ul class="tabs">
        {#each tabsList as tab}
            <a href={tab.route} class="tab">
                <span class="icon">
                    <Icon icon={tab.icon} width="1em" height="1em" />
                </span>
                <span>
                    {tab.name}
                </span>
            </a>
        {/each}
    </ul>
    <div class="user">
        {#if user}
        <span>Залогинен</span>
        {:else}
        <span>Незалогинен</span>
        {/if}
    </div>
</nav>

<style lang="scss">
    @import "./Navbar.scss";
    @import "./Navbar.mobile.scss";
</style>