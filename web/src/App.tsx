import { useRef, useState } from "react"
import { Toaster } from "sonner"
import Header from "./components/Header"
import SearchByGoban from "./components/SearchByGoban"
import SearchByUrl from "./components/SearchByUrl"
import { Card, CardContent } from "./components/ui/card"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "./components/ui/tabs"
import VideoList from "./components/VideoList"
import Provider from "./provider"
import CardSizeProvider from "./provider/CardSizeProvider"
import JosekiProvider from "./provider/JosekiProvider"

function App() {
  const [videoIds, setVideoIds] = useState<Array<string> | null>([])
  const cardRef = useRef<HTMLDivElement>(null)

  return (
    <Provider>
      <div className="h-screen w-screen flex flex-col font-noto-sans-jp">
        <Toaster position="bottom-left" expand richColors />
        <Header />
        <div className="flex flex-col lg:flex-row justify-around items-center gap-4 p-4 lg:h-[calc(100%-64px)]">
          <JosekiProvider>
            <CardSizeProvider>
              <Tabs defaultValue="goban" className="self-stretch">
                <Card className="h-full" ref={cardRef}>
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
            </CardSizeProvider>
          </JosekiProvider>
          <Card className="grow self-stretch p-0 lg:p-0">
            <CardContent className="p-0 lg:p-0 h-full">
              <VideoList videoIds={videoIds} />
            </CardContent>
          </Card>
        </div>
      </div>
    </Provider>
  )
}

export default App
