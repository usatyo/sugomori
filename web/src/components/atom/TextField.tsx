import { type FC } from "react"

type Props = {
  value: string
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void
}

const TextField: FC<Props> = ({ value, onChange }) => {
  return <input type="text" value={value} onChange={onChange} className="" />
}

export default TextField
