import { useEffect, useRef, useState } from "react"
import SearchByGoban from "./components/SearchByGoban"
import SearchByUrl from "./components/SearchByUrl"
import { Card, CardContent } from "./components/ui/card"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "./components/ui/tabs"
import VideoList from "./components/VideoList"
import JosekiProvider from "./provider/JosekiProvider"

function App() {
  const [videoIds, setVideoIds] = useState<Array<string> | null>([])
  const cardRef = useRef<HTMLDivElement>(null)
  const [width, setWidth] = useState<number>(0)

  useEffect(() => {
    if (cardRef.current) {
      // padding + height の分を引く
      setWidth(cardRef.current.offsetHeight - 156)
    }
  }, [])

  return (
    <div className="flex justify-around items-center gap-4 p-4 h-screen">
      <JosekiProvider>
        <Tabs defaultValue="goban" className="w-fit self-stretch">
          <Card className="h-full" ref={cardRef} style={{ width: width }}>
            <CardContent className="h-full flex flex-col gap-4">
              <TabsList className="w-full">
                <TabsTrigger value="goban">碁盤で検索</TabsTrigger>
                <TabsTrigger value="url">URLで検索</TabsTrigger>
              </TabsList>
              <TabsContent value="goban" asChild>
                <SearchByGoban setVideoIds={setVideoIds} />
              </TabsContent>
              <TabsContent value="url" asChild>
                <SearchByUrl setVideoIds={setVideoIds} />
              </TabsContent>
            </CardContent>
          </Card>
        </Tabs>
      </JosekiProvider>
      <Card className="grow self-stretch p-0">
        <CardContent className="p-0 h-full">
          <VideoList videoIds={videoIds} />
        </CardContent>
      </Card>
    </div>
  )
}

export default App
