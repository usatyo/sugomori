import { CardSizeContext } from "@/provider/CardSizeProvider"
import { LoadingContext } from "@/provider/LoadingProvider"
import {
  useContext,
  useEffect,
  useState,
  type Dispatch,
  type FC,
  type SetStateAction,
} from "react"
import { Button } from "../ui/button"
import { Input } from "../ui/input"
import { Label } from "../ui/label"

type Props = {
  setVideoIds: Dispatch<SetStateAction<string[] | null>>
}

const SearchByUrl: FC<Props> = ({ setVideoIds }) => {
  const [givenLink, setGivenLink] = useState<string>("")
  const [errorMessage, setErrorMessage] = useState<string>("")
  const { loading } = useContext(LoadingContext)
  const { size } = useContext(CardSizeContext)

  const handleSearch = async () => {
    try {
      setVideoIds(null)
      const url = new URL(givenLink)
      const videoId = url.searchParams.get("v")
      setVideoIds(videoId !== null ? [videoId] : [])
    } catch (e) {
      setVideoIds([])
    }
  }

  useEffect(() => {
    setErrorMessage("")
    if (givenLink === "") {
      return
    }
    try {
      const url = new URL(givenLink)
      if (url.hostname !== "www.youtube.com" && url.hostname !== "youtu.be") {
        setErrorMessage("YouTubeのURLを入力してください")
        return
      }
      if (url.searchParams.get("v") === null) {
        setErrorMessage("動画を再生することのできるURLを入力してください")
        return
      }
    } catch (e) {
      setErrorMessage("正しいURLを入力してください")
    }
  }, [givenLink])

  return (
    <>
      <div style={{ width: size }}>
        <Label htmlFor="youtube_link_input">YouTube URL</Label>
        <Input
          id="youtube_link_input"
          value={givenLink}
          onChange={(e) => setGivenLink(e.target.value)}
          placeholder="https://youtube.com/watch?v=..."
          className="mt-2 w-full"
        />
        <span className="text-sm text-destructive ml-2">{errorMessage}</span>
      </div>
      <Button onClick={handleSearch} className="w-full" disabled={loading}>
        検索する
      </Button>
    </>
  )
}

export default SearchByUrl
