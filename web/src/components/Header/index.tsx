import type { FC } from "react"
import GuidanceDialog from "./GuidanceDialog"

type Props = {}

const Header: FC<Props> = () => {
  return (
    <header className="w-full py-4 px-6 bg-primary flex justify-between items-center">
      <h1 className="text-white font-montserrat text-2xl">sugomori</h1>
      <GuidanceDialog />
    </header>
  )
}

export default Header
