import { useState } from "react"
import FlatButton from "./components/atom/FlatButton"
import TextField from "./components/atom/TextField"
import Goban from "./components/Goban"
import VideoCard from "./components/VideoCard"
import useJosekiApi from "./hooks/useJosekiApi"
import JosekiProvider from "./provider/JosekiProvider"

function App() {
  const [givenLink, setGivenLink] = useState<string>("")
  const { getHello } = useJosekiApi()

  return (
    <JosekiProvider>
      <div className="flex">
        <div className="flex flex-col">
          <TextField
            value={givenLink}
            onChange={(e) => setGivenLink(e.target.value)}
          />
          <Goban />
          <FlatButton variant="filled" onClick={getHello}>
            検索する
          </FlatButton>
        </div>
        <div>
          <VideoCard videoId="kZrLTFegqwQ" />
          <VideoCard videoId="kZrLTFegqwQ" />
          <VideoCard videoId="kZrLTFegqwQ" />
          <VideoCard videoId="kZrLTFegqwQ" />
        </div>
      </div>
    </JosekiProvider>
  )
}

export default App
