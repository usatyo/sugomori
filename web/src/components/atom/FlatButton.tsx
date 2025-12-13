import type { FC, MouseEventHandler, PropsWithChildren } from "react"

type Props = {
  variant?: "filled" | "outlined",
  onClick?: MouseEventHandler<HTMLButtonElement>
}

const FlatButton: FC<PropsWithChildren<Props>> = ({ children, variant = "filled", onClick }) => {
  if (variant === "outlined") {
    return <button className="border border-blue-500" onClick={onClick}>{children}</button>
  } else {
    return <button className="bg-blue-500 text-white rounded-md w-fit p-2" onClick={onClick}>{children}</button>
  }
}

export default FlatButton
