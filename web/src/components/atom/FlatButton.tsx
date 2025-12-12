import type { FC, ReactNode } from "react"

type Props = {
  children: ReactNode
  variant?: "filled" | "outlined"
}

const FlatButton: FC<Props> = ({ children, variant = "filled" }) => {
  if (variant === "outlined") {
    return <button>{children}</button>
  } else {
    return <button>{children}</button>
  }
}

export default FlatButton
