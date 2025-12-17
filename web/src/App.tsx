import { useState, type ReactNode } from "react"
import SearchByGoban from "./components/SearchByGoban"
import SearchByUrl from "./components/SearchByUrl"
import { Card, CardContent } from "./components/ui/card"
import { ScrollArea } from "./components/ui/scroll-area"
import { Separator } from "./components/ui/separator"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "./components/ui/tabs"
import VideoItem from "./components/VideoItem"
import JosekiProvider from "./provider/JosekiProvider"

function App() {
  const [videoIds, setVideoIds] = useState<Array<string>>([])

  return (
    <div className="flex justify-around items-center gap-4 p-4 h-screen">
      <JosekiProvider>
        <Tabs defaultValue="goban" className="grow self-stretch">
          <Card className="h-full">
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
      <Card className="self-stretch">
        <CardContent>
          <ScrollArea>
            {videoIds
              .map((videoId) => <VideoItem key={videoId} videoId={videoId} />)
              .reduce<ReactNode[]>((prev, curr) => {
                return [...prev, curr, <Separator />]
              }, [])
              .slice(0, -1)}
          </ScrollArea>
        </CardContent>
      </Card>
    </div>
  )
}

export default App
