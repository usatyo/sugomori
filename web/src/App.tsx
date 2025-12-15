import { useContext, useState } from "react"
import Goban from "./components/Goban"
import VideoCard from "./components/VideoCard"
import useJosekiApi from "./hooks/useJosekiApi"
import { JosekiContext } from "./provider/JosekiProvider"
import { Button } from "./components/ui/button"
import { Input } from "./components/ui/input"

function App() {
  const [givenLink, setGivenLink] = useState<string>("")
  const [videoIds, setVideoIds] = useState<Array<string>>([])
  const { getVideos } = useJosekiApi()
  const { joseki } = useContext(JosekiContext)

  const handleSearch = async () => {
    const videos = await getVideos(joseki)
    setVideoIds(videos)
  }

  return (
    <div className="flex">
      <div className="flex flex-col">
        <Input value={givenLink} onChange={(e) => setGivenLink(e.target.value)} />
        <Goban />
        <Button onClick={handleSearch}>検索する</Button>
      </div>
      <div>
        {videoIds.map((videoId) => (
          <VideoCard key={videoId} videoId={videoId} />
        ))}
      </div>
    </div>
  )
}

export default App
