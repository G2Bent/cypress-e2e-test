
export const languages = ['zh-CN','en-US']

export const getRandNum = (array)=>{
    let num = Math.floor(Math.random()*array.length)
    return num
}