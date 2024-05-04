import React, { useState } from 'react'
import { Icon } from "@iconify/react"
import style from "./ModalAlert.module.scss"
import Modal from '../Modal/Modal'

const ModalAlert = ({visible = undefined, header = undefined, body, onClick = () => {}, closable = true, iconClass = "", icon = "", buttonText = "ОК", state = undefined}) => {
  let modal;
  return (
    <Modal ref={modal} visible={visible} header={header} closable={closable} icon={icon} iconClass={iconClass} state={state}>
        <p>{body}</p>
        <button onClick={onClick} className={style.greenButton} >{buttonText}</button>
    </Modal>
  )
}

export default ModalAlert
