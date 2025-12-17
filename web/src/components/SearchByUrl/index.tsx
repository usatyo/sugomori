import { useState, type Dispatch, type FC, type SetStateAction } from "react"
import { Button } from "../ui/button"
import { Input } from "../ui/input"
import { Label } from "../ui/label"

type Props = {
  setVideoIds: Dispatch<SetStateAction<string[]>>
}

const SearchByUrl: FC<Props> = ({ setVideoIds }) => {
  const [givenLink, setGivenLink] = useState<string>("")

  const handleSearch = async () => {
    try {
      const url = new URL(givenLink)
      const videoId = url.searchParams.get("v")
      setVideoIds([videoId ?? ""])
    } catch (e) {
      // TODO: エラーハンドリング
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
      <Button onClick={handleSearch} className="w-full">
        検索する
      </Button>
    </>
  )
}

export default SearchByUrl
