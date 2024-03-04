import { TabPanel, TabView } from 'primereact/tabview';
import Selected from './component/selected';
import Sql from './component/sql';

export default async function Home() {
    return (
        <main className='flex justify-center'>
            <TabView className='w-full'>
                <TabPanel header="Select">
                    <Selected />
                </TabPanel>
                <TabPanel header="SQL">
                    <Sql />
                </TabPanel>
            </TabView>
        </main>
    );
}
