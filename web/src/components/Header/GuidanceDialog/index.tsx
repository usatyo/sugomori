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
import { CircleQuestionMarkIcon, CopyIcon } from "lucide-react"
import type { FC } from "react"
import { toast } from "sonner"

type Props = {}

const GuidanceDialog: FC<Props> = () => {
  const onClickEmail = () => {
    navigator.clipboard.writeText("dtotb33333@gmail.com")
    toast.info("メールアドレスをコピーしました")
  }
  
  return (
    <Dialog>
      <DialogTrigger className="cursor-pointer">
        <CircleQuestionMarkIcon color="white" size={28} />
      </DialogTrigger>
      <DialogContent className="max-w-7/8! w-[700px] font-noto-sans-jp">
        <DialogHeader>
          <DialogTitle className="text-lg font-bold">
            sugomori の使い方
          </DialogTitle>
        </DialogHeader>
        <Separator />
        <h2 className="font-bold">碁盤・URLで検索</h2>
        <p className="px-2">
          定石手順を入力することで、登録済みの動画から似た内容のものを検索できます。回転・反転した盤面で検索しても問題ありません。
          「動画に関連する定石手順」を変更することで、碁盤検索の結果に影響を与えることができます。
        </p>
        <Separator />
        <h2 className="font-bold">注意事項</h2>
        <p className="px-2">
          sugomori
          はユーザーが入力した定石手順を元に動作しています。動画や定石手順の内容に関する責任は負いかねますのでご了承ください。
          また、入力された定石手順はサービス向上のために利用される場合があります。
        </p>
        <Separator />
        <p className="px-2">
          {/* 詳細は
          <a href="" target="_blank" rel="noopener noreferrer">
            こちら
          </a>
          の動画から確認いただけます。
          <br /> */}
          お問い合わせがありましたら、
          <Button
            variant="link"
            className="cursor-pointer text-md"
            onClick={onClickEmail}
          >
            dtotb33333@gmail.com
            <CopyIcon className="inline mt-1" size={16} />
          </Button>
          までご連絡ください。
        </p>
        <DialogClose>
          <Button className="w-1/2">OK</Button>
        </DialogClose>
      </DialogContent>
    </Dialog>
  )
}

export default GuidanceDialog
