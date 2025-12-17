import {
  ChevronFirstIcon,
  ChevronLeftIcon,
  ChevronsLeftIcon,
  RedoIcon,
} from "lucide-react"
import type { FC } from "react"
import { Button } from "../../ui/button"
import { ButtonGroup } from "../../ui/button-group"
import useOperationArea from "./useOperationArea"

type Props = {}

const OperationArea: FC<Props> = () => {
  const { clear, backFive, back, pass } = useOperationArea()

  return (
    <ButtonGroup className="mx-auto">
      <Button variant="outline" onClick={clear}>
        <ChevronFirstIcon />
        リセット
      </Button>
      <Button variant="outline" onClick={backFive}>
        <ChevronsLeftIcon />
        5手戻る
      </Button>
      <Button variant="outline" onClick={back}>
        <ChevronLeftIcon />
        1手戻る
      </Button>
      <Button variant="outline" onClick={pass}>
        <RedoIcon />
        手抜き
      </Button>
    </ButtonGroup>
  )
}

export default OperationArea
