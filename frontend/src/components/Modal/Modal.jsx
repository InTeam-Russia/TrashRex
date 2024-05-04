import React from 'react'
import { Icon } from "@iconify/react"
import style from "./Modal.module.scss"

const Modal = ({shown, header, body, onClick, buttonText}) => {
  
  return (
    <div className={`${style.modalScreen} ${!shown ? style.hidden : ''}`}>
        <section className={style.modal}>
            <h1>{header}</h1>
            <p>{body}</p>
            <button onClick={onClick} className={style.greenButton} >{buttonText}</button>
        </section>
    </div>
  )
}

export default Modal
