import { LoadingContext } from "@/provider/LoadingProvider"
import {
  useContext,
  useState,
  type Dispatch,
  type FC,
  type SetStateAction,
} from "react"
import { toast } from "sonner"
import { Button } from "../ui/button"
import { Input } from "../ui/input"
import { Label } from "../ui/label"

type Props = {
  setVideoIds: Dispatch<SetStateAction<string[] | null>>
}

const SearchByUrl: FC<Props> = ({ setVideoIds }) => {
  const [givenLink, setGivenLink] = useState<string>("")
  const { loading } = useContext(LoadingContext)

  const handleSearch = async () => {
    try {
      setVideoIds(null)
      const url = new URL(givenLink)
      const videoId = url.searchParams.get("v")
      setVideoIds(videoId !== null ? [videoId] : [])
    } catch (e) {
      toast.error("無効なURLです")
      setVideoIds([])
    }
  }

  return (
    <>
      <div>
        <Label htmlFor="youtube_link_input">YouTube URL</Label>
        <Input
          id="youtube_link_input"
          value={givenLink}
          onChange={(e) => setGivenLink(e.target.value)}
          placeholder="https://youtube.com/watch?v=..."
          className="mt-2 w-full"
        />
      </div>
      <p>
        複数の動画を検索したい場合は、1つずつ検索して結果を統合してください。
      </p>
      <Button onClick={handleSearch} className="w-full" disabled={loading}>
        検索する
      </Button>
    </>
  )
}

export default SearchByUrl
