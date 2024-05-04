import React, { useState, useEffect } from 'react'
import { Icon } from "@iconify/react"
import style from "./Modal.module.scss"

const Modal = ({ visible = undefined, header, children, closable = true, iconClass = "", icon = "", state = undefined }) => {
    const [_visible, _setVisible] = useState(false);
    const open = () => {
        _setVisible(true);
    }
    const hide = () => {
        _setVisible(false);
    }
    const toggle = () => {
        _setVisible(!_visible)
    }
    useEffect(() => {
        if(!state) {
            return
        }
        _setVisible(state.visible)
    },[state])
    return (
        <div className={`${style.modalScreen} ${!_visible ? style.hidden : ''}`}>
            <section className={style.modal}>
                <div className={style.header}>
                    {icon ?
                        <Icon className={style.icon + " " + iconClass} icon={icon} />
                        :
                        <></>
                    }
                    {header ?
                        <h1>{header}</h1>
                        :
                        <></>
                    }
                    {closable ?
                        <a><Icon onClick={hide} className={style.close} icon="solar:close-square-bold" /></a>
                        :
                        <></>
                    }
                </div>
                {children}
            </section>
        </div>
    )
}

export default Modal
