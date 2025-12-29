import { LoadingContext } from "@/provider/LoadingProvider"
import {
  ChevronFirstIcon,
  ChevronLeftIcon,
  ChevronsLeftIcon,
  PencilOffIcon,
  RedoIcon,
} from "lucide-react"
import { useContext, type FC } from "react"
import { Button } from "../../ui/button"
import { ButtonGroup } from "../../ui/button-group"
import useOperationArea from "./useOperationArea"

type Props = {}

const OperationArea: FC<Props> = () => {
  const { clear, backFive, back, pass, isEditable } = useOperationArea()
  const { loading } = useContext(LoadingContext)

  return (
    <div className="flex justify-center items-center gap-4 @container">
      <ButtonGroup>
        <Button
          variant="outline"
          onClick={clear}
          disabled={!isEditable || loading}
        >
          <ChevronFirstIcon />
          <span className="@max-[508px]:hidden">リセット</span>
        </Button>
        <Button
          variant="outline"
          onClick={backFive}
          disabled={!isEditable || loading}
        >
          <ChevronsLeftIcon />
          <span className="@max-[508px]:hidden">5手戻る</span>
        </Button>
        <Button
          variant="outline"
          onClick={back}
          disabled={!isEditable || loading}
        >
          <ChevronLeftIcon />
          <span className="@max-[508px]:hidden">1手戻る</span>
        </Button>
      </ButtonGroup>
      <ButtonGroup>
        <Button
          variant="outline"
          onClick={pass}
          disabled={!isEditable || loading}
        >
          <RedoIcon />
          <span>手抜き</span>
        </Button>
      </ButtonGroup>
      {!isEditable && (
        <div className="flex items-center gap-2">
          <PencilOffIcon size={16} />
          <span className="text-sm @max-[508px]:hidden">編集不可</span>
        </div>
      )}
    </div>
  )
}

export default OperationArea
