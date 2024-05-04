<script>
    const emailRegex = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$/
    const vkRegex = /^https:\/\/vk\.com\/[a-zA-Z0-9_]+$/
    const tgRegex = /^https:\/\/t\.me\/[a-zA-Z0-9_]+$/

    let isAuth = true
    let authForm = {
        email: "",
        password: ""
    }

    let authFormValidate = {
        isEmailPattern: true,
    }

    let regForm = {
        email: "",
        name: "",
        surname: "",
        imgSrc: "img/defaultUser.webp",
        telegram: "",
        vk: "",
        password: "",
        repeatedPassword: "",
    }

    let regFormValidate = {
        isEmailPattern: true,
        isVkPattern: true,
        isTgPattern: true,
        isPasswordsMatch: true,
        isVkOrTg: true,
    }

    const validateForm = (event) => {
        let flag = false
        if (isAuth) {
            authFormValidate.isEmailPattern = emailRegex.test(authForm.email)
            flag = flag && emailRegex.test(authForm.email)
        } else {
            regFormValidate.isEmailPattern = emailRegex.test(regForm.email)
            flag = flag && emailRegex.test(regForm.email)
            regFormValidate.isVkPattern = vkRegex.test(regForm.vk)
            flag = flag && vkRegex.test(regForm.vk)
            regFormValidate.isTgPattern = tgRegex.test(regForm.telegram)
            flag = flag && tgRegex.test(regForm.telegram)
            regFormValidate.isPasswordsMatch = (regForm.password === regForm.repeatedPassword)
            flag = flag && (regForm.password === regForm.repeatedPassword)
            regForm.isVkOrTg = (regForm.vk + regForm.telegram !== "")
            flag = flag && (regForm.vk + regForm.telegram !== "")
        }

        return !flag
    }

    const handleSubmit = (event) => {
        if (!validateForm()) return
        
        if (isAuth) {
            const res = {...authForm}

            fetch("http://10.1.0.101:8000/user/login", {
                method: "POST",
                body: JSON.stringify(res),
                headers: {
                    "Content-Type": "application/json"
                }
            })
            .then(response => response.json())
            .catch(() => {alert("Ошибка сервера, попробуйте позднее")})
        } else {
            const res = {
                email: regForm.email,
                password: regForm.password,
                name: regForm.name ? regForm.name : null,
                surname: regForm.surname ? regForm.surname : null,
                is_active: true,
                is_superuser: false,
                is_verified: false,
                vk: regForm.vk ? regForm.vk : null,
                telegram: regForm.telegram ? regForm.telegram : null,
            }

            fetch("http://10.1.0.101:8000/user/register", {
                method: "POST",
                body: JSON.stringify(res),
                headers: {
                    "Content-Type": "application/json"
                }
            })
            .then(response => response.json())
            .catch(() => {alert("Ошибка сервера, попробуйте позднее")})
        }
    }
</script>

<section>
    <h1>
        <span class={isAuth && "active"} on:click={() => {isAuth = true}}>Вход</span>
        <span class={!isAuth && "active"} on:click={() => {isAuth = false}}>Регистрация</span>
    </h1>
    <form method="post" on:submit|preventDefault={handleSubmit}>
        {#if isAuth}
            <input type="email"  bind:value={authForm.email} required placeholder="Электронная почта" class="text">
            <span class={`error ${authFormValidate.isEmailPattern ? "hidden" : ""}`}>
                Почта не удовлетворяет формату example@domain.com
            </span>
            <input type="password" bind:value={authForm.password} required placeholder="Пароль" class="text">
        {:else}
            <input type="email" bind:value={regForm.email} required placeholder="Электронная почта" class="text">
            <span class={`error ${regFormValidate.isEmailPattern ? "hidden" : ""}`}>
                Почта не удовлетворяет формату example@domain.com
            </span>
            <input type="text" bind:value={regForm.name} required placeholder="Имя" class="text">
            <input type="text" bind:value={regForm.surname} required placeholder="Фамилия" class="text">
            <input type="text" bind:value={regForm.vk} placeholder="ВК (ссылка на профиль)" class="text">
            <span class={`error ${regFormValidate.isVkPattern ? "hidden" : ""}`}>
                Ссылка не удовлетворяет формату https://vk.com/example
            </span>
            <input type="text" bind:value={regForm.telegram} placeholder="Telegram (ссылка на профиль)" class="text">
            <span class={`error ${regFormValidate.isTgPattern ? "hidden" : ""}`}>
                Ссылка не удовлетворяет формату https://t.me/example
            </span>
            <input type="password" bind:value={regForm.password} required placeholder="Пароль" class="text">
            <input type="password" bind:value={regForm.repeatedPassword} required placeholder="Повтор пароля" class="text">
            <span class={`error ${regFormValidate.isPasswordsMatch ? "hidden" : ""}`}>
                Пароли не совпадают
            </span>
            <span class={`error ${regFormValidate.isVkOrTg ? "hidden" : ""}`}>
                Введите хотя бы одну социальную сеть
            </span>
        {/if}
        <div>
            <input type="submit" value={isAuth ? "Войти" : "Зарегистрироваться"}>  
            <input type="reset" value="Сбросить">  
        </div>
    </form>
</section>

<style lang="scss">
    @import "./authreg.scss";
    @import "./authreg.mobile.scss";    
</style>