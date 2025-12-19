import { Button } from "@/components/ui/button"
import {
  Dialog,
  DialogClose,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog"
import { Separator } from "@/components/ui/separator"
import { CircleQuestionMarkIcon } from "lucide-react"
import type { FC } from "react"

type Props = {}

const GuidanceDialog: FC<Props> = () => {
  return (
    <Dialog>
      <DialogTrigger className="cursor-pointer">
        <CircleQuestionMarkIcon color="white" size={28} />
      </DialogTrigger>
      <DialogContent>
        <DialogHeader>
          <DialogTitle className="text-lg font-bold">
            sugomori の使い方
          </DialogTitle>
        </DialogHeader>
        <Separator />
        <h2 className="font-bold">碁盤で検索</h2>
        <p className="px-2">
          定石手順を入力することで、登録済みの動画から似た内容のものを検索できます。回転・反転した盤面で検索しても問題ありません。
        </p>
        <Separator />
        <h2 className="font-bold">URLで検索</h2>
        <p className="px-2">
          URLを貼り付けることで、動画を検索できます。検索結果から対象の動画をクリックして、下の碁盤から動画と関連する定石手順を入力すれば、「碁盤で検索」から検索できるようになります。関連する定石は最大で5個まで追加可能です。
        </p>
        <DialogClose>
          <Button className="w-1/2">OK</Button>
        </DialogClose>
      </DialogContent>
    </Dialog>
  )
}

export default GuidanceDialog
